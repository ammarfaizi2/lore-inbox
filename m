Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVBGT44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVBGT44 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBGTxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:53:22 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:756 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261271AbVBGTtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:49:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IIlqx5+7NHjBj48yLWWktE6OUPR8U9sum3gvoJ8rSbV0BOyzG8LEOa2BRSLgCD1X4RJv/lAUKRxBm5Fa0M6Wt0NTjO53yaxv5QCa1689NXroKF60425BL7zX4CsfGj5stmeVT5ySm7MNiPmznCQjBg0XxsavjOmh2nDpZe4LuV0=
Message-ID: <d120d500050207114959466682@mail.gmail.com>
Date: Mon, 7 Feb 2005 14:49:33 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: trelane@digitasaru.net, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, petero2@telia.com
Subject: Re: [ATTN: Dmitry Torokhov] About the trackpad and 2.6.11-rc[23] but not -rc1
In-Reply-To: <20050207191615.GC12024@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050207154326.GA13539@digitasaru.net>
	 <d120d50005020708512bb09e0@mail.gmail.com>
	 <20050207180950.GA12024@digitasaru.net>
	 <d120d50005020710591181fe69@mail.gmail.com>
	 <20050207190541.GB12024@digitasaru.net>
	 <d120d5000502071112599fa61c@mail.gmail.com>
	 <20050207191615.GC12024@digitasaru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005 13:16:15 -0600, Joseph Pingenot
<trelane@digitasaru.net> wrote:
> From Dmitry Torokhov on Monday, 07 February, 2005:
> >On Mon, 7 Feb 2005 13:05:41 -0600, Joseph Pingenot
> ><trelane@digitasaru.net> wrote:
> >> From Dmitry Torokhov on Monday, 07 February, 2005:
> >> >On Mon, 7 Feb 2005 12:09:50 -0600, Joseph Pingenot
> >> ><trelane@digitasaru.net> wrote:
> >> >> From Dmitry Torokhov on Monday, 07 February, 2005:
> >> >> >Nonetheless it would be nice to see the data stream from the touchpad
> >> >> >to see why our ALPS support does not work quite right. Could you
> >> >> >please try booting with "log_buf_len=131072 i8042.debug=1", and
> >> >> >working the touchpad a bit. then send me the output of "dmesg -s
> >> >> >131072" (or just /var/log/messages).
> >> >> dmesg output, non-mouse output trimmed (for obvious reasons, if you think
> >> >>  about it ;) is attached.
> >> >I am sorry, I was not clear enough. I'd like to see -rc2 (the broken
> >> >one), complete with bootup process, so we will see why it can't
> >> >synchronize at all. (I of course don't need keyboard data of anything
> >> >that has been typed after boot).
> >> They're both broken in about the same way, iirc.  Is there something special
> >>  in -rc2 that's not in -rc3?
> >No, -rc3 will do as well. Any version starting with -rc2 should do the trick.
> 
> All info in the mail to which you repsonded were from -rc3, including
>  and especially the attachemnt.  The only info I sent from -rc1 was the
>  contents of /proc/bus/input/devices in response to the *original* request.
> 

Ah, I see. Well, the data in foo.gz file looks like standard PS/2
protocol, it would be interesting to see the beginning of the dmesg
(where we do all the detection). It looks like something has reset the
absolute mode back to standard relative one.

-- 
Dmitry
