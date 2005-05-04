Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVEDTeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVEDTeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVEDTeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:34:11 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:10670 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261426AbVEDTeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:34:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VzCKumuLcMbPSuy92xlOfjcIKYT6GNbZDygvKVtOwtTzIn2lbQ9QQiXbxkwnCgyv+w6Mk5L/kMp66bLUix+6RehfUSAUgNMWW7aUds7RqB3tZtg473pjPrwMUA62HOOXHHXdNQLTw5nSkKvNghbYsnVVHWRR2Mgruk9Wg7Sw4NM=
Message-ID: <d120d50005050412341159db43@mail.gmail.com>
Date: Wed, 4 May 2005 14:34:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: A patch for the file kernel/fork.c
Cc: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200505041911.j44JBhda022528@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4278E03A.1000605@cachola.com.br>
	 <20050504175457.GA31789@taniwha.stupidest.org>
	 <427913E4.3070908@cachola.com.br>
	 <200505041911.j44JBhda022528@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 04 May 2005 15:26:44 -0300, =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= said:
> 
> > In a preemptible kernel with the serport module and a serial port try to
> > run the following program:
> 
> > and kill it.
> > In my case it will hang the computer. I think this is a problem with the
> > serport module. With this patch, the serial mouse stop working, but the
> > computer don't hang.
> 
> The fact that the mouse stops working is indicative that this patch doesn't
> actually fix the problem, it's just pushing it around in the kernel - sooner
> or later something *else* is going to go pear-shaped on the null *mm.  The right
> fix is to figure out why mm is bogus and fix that issue.
> 

serport module is busted at the moment. Look here for the patch:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/broken-out/serport-oops-fix.patch

It should probably go into -stable but Vojtech seems to have
disappeared... I think Fedora already picked it up.

-- 
Dmitry
