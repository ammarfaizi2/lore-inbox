Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030597AbVKRJhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030597AbVKRJhw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 04:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030598AbVKRJhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 04:37:52 -0500
Received: from main.gmane.org ([80.91.229.2]:8930 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030597AbVKRJhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 04:37:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Fri, 18 Nov 2005 10:37:03 +0100
Organization: Doodads Olivia Decades
Message-ID: <87u0eathz4.fsf@obelix.mork.no>
References: <87zmoa0yv5.fsf@obelix.mork.no>
	<d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: obelix.mork.no
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:bPhUT6u/2oSRz3pV+IZ4X3mrnio=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> On 11/12/05, Bjørn Mork <bmork@dod.no> wrote:
>> IPv6 over IPv4 tunneling driver
>> NET: Registered protocol family 17
>> Using IPI Shortcut mode
>> Stopping tasks: ===<6>Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
>> serio: Synaptics pass-through port at isa0060/serio1/input0
>> input: SynPS/2 Synaptics TouchPad as /class/input/input1
>>
>>  stopping tasks failed (1 tasks remaining)
>> Restarting tasks...<6> Strange, kseriod not stopped
>>  done
>
> Crazy idea - did you let it finish booting or you hit suspend as soon
> as you could? It looks like kseriod was busy discovering your
> touchpad/trackpoint for the first time...

The boot was complete, even including X running.

> Anyway, Pavel, I think 6 seconds it too short of a timeout for
> stopping all tasks. PS/2 is pretty slow, trackpad reset can take up to
> 2 seconds alone...
>
> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?

Yup.  Resume is working with this change in an otherwise unchanged
2.6.15-rc1, so that seems to be it.

Thanks.


Bjørn
-- 
You sound like a real weakling.

