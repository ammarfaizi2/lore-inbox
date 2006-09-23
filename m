Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWIWNXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWIWNXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 09:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWIWNXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 09:23:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:27194 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751110AbWIWNXU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 09:23:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ASCQXaQ/4q1M4aL5MJNxwVGU09O+qaa0/OmUHT9Nuk81tworoU/lYmubYCHejz8AL+9mFXEYTXQVeBfhEchamBUVneHvSQYG2LyucYHDwa1yovbQftIghq6LolV22P53ZfxTArTvVzdHWqsEUR9u4+D7/8FlsDt3d3L1zYc8dVY=
Message-ID: <d9def9db0609230623k6ccfedbp1cd5be8ec25d176d@mail.gmail.com>
Date: Sat, 23 Sep 2006 15:23:19 +0200
From: "Markus Rechberger" <mrechberger@gmail.com>
To: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] snd-usb-audio problems with 2.6.18
In-Reply-To: <20060923125456.GA7757@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060923125456.GA7757@hardeman.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

this issue might be hidden within the usb subsystem.
USB bandwidth allocation doesn't work 100% yet afaik, better turn off
support for it when configuring your kernel.

Markus

On 9/23/06, David Härdeman <david@hardeman.nu> wrote:
> A recent 2.6.18 kernel upgrade on one of my machines broke usb audio.
>
> I'm using a TerraTec Aureon 5.1 USB MKII to feed ac3 audio to a
> receiver, but after the upgrade, trying to play any audio (tried aplay,
> mplayer, xine, etc...using both oss and alsa audio) results in the
> kernel log being filled with the message:
>
> "cannot submit datapipe for urb 5, error -28: not enough bandwidth"
>
> Unfortunately the upgrade was from 2.6.14 (yes, it's old but the machine
> has no network connection usually) so there is quite a lot of
> differences to the snd-usb-audio driver in the meantime.
>
> Unless someone has suggestions as to a simple fix, I guess I'll
> start testing kernels in the 2.6.14 <-> 2.6.18 range soon to try to pin
> down a certain changeset...
>
> --
> David Härdeman
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-- 
Markus Rechberger
