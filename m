Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUHTQYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUHTQYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268319AbUHTQYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:24:46 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:4878 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S268312AbUHTQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:24:32 -0400
Date: Fri, 20 Aug 2004 18:20:27 +0200
From: DervishD <disposable1@telefonica.net>
To: William Lee Irwin III <wli@holomorphy.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: setproctitle
Message-ID: <20040820162027.GA1238@DervishD>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040818082851.GA32519@DervishD> <20040818085850.GW11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040818085850.GW11200@holomorphy.com>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi William :)

 * William Lee Irwin III <wli@holomorphy.com> dixit:
> >     In proc/base.c you can read about 'setproctitle(3)', that is, in
> > library space (user space), not kernel space, but AFAIK only FreeBSD
> > has setproctitle :?
> Observe the following, from fs/proc/base.c:
[...]
> The command-line arguments are being fetched from the process address
> space, i.e. simply editing argv[] in userspace will have the desired
> effect. Though this code is butt ugly.

    The problem with this is that is non-portable. Not all Unices
(AFAIK) have this behaviour. The portable solution for changing
argv[0] is to use ONLY the space currently allocated to argv[0]. I
mean, you take argv[0], do a strlen() and overwrite only strlen bytes
of it. The problem with this is that you cannot write an arbitrary
string there. If all Unices provide 'setproctitle' that problem
dissapears.

    Anyway is cool to know that, under Linux, I can change the
argv[0] with no problems.

    Thanks for the help :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
