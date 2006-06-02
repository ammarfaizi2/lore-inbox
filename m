Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWFBOkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWFBOkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWFBOkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:40:36 -0400
Received: from mx-serv.inrialpes.fr ([194.199.18.100]:14475 "EHLO
	mx-serv.inrialpes.fr") by vger.kernel.org with ESMTP
	id S932138AbWFBOkf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:40:35 -0400
From: =?iso-8859-1?q?Aur=E9lien_Francillon?= <aurel@naurel.org>
Reply-To: aurel@naurel.org
To: Ram <vshrirama@gmail.com>
Subject: Re: printk's - i dont want any limit howto?
Date: Fri, 2 Jun 2006 16:40:25 +0200
User-Agent: KMail/1.8.3
Cc: "Paulo Marques" <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
References: <8bf247760606010025p38131240ia133cc3124f93bf7@mail.gmail.com> <447EEDCB.1070002@grupopie.com> <8bf247760606020037x7eedab52qa9c736bdba740cb8@mail.gmail.com>
In-Reply-To: <8bf247760606020037x7eedab52qa9c736bdba740cb8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606021640.25531.aurel@naurel.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (mx-serv.inrialpes.fr [194.199.18.100]); Fri, 02 Jun 2006 16:40:26 +0200 (MEST)
X-mx-serv-inrialpes-fr-MailScanner-Information: Please contact postmaster@inrialpes.fr for more information
X-mx-serv-inrialpes-fr-MailScanner: Found to be clean
X-mx-serv-inrialpes-fr-MailScanner-SpamCheck: n'est pas un polluriel,
	SpamAssassin (score=0, requis 6)
X-mx-serv-inrialpes-fr-MailScanner-From: aurel@naurel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 09:37, Ram wrote:
> Hi,
>   Actually even though the printks are getting executed.
>
>   ONLY some appear. I have given both KERN_ERR and KERN_DEBUG
>
>
>    Its not the log level problem. probably the buffer or something else.
>    am not sure on that.
...

Increasing the "Kernel log buffer size" (under Kernel hacking config menu) to 
a bigger value helps to prevent overwriting the kernel circular buffer.
Using synchronous writes in syslog usually helps to get all the messages 
written to disk before a kernel crash
HTH,
Aurélien

