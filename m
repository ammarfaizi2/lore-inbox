Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWG3MmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWG3MmU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWG3MmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:42:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:57755 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932294AbWG3MmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:42:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jAnjmjsl+/w3g4p0Szy3cuJc0IMFvI8WBJZsRPD5xXadbhL/TW0eNoXEsaVAy9IYZmgnzq2M+ozIIhGo7+dYlsIS4kL+LqzjO0oQ4oPDUllnCrlU2fLAefxm1E+p38qaCaqMBEVgPsxrjmQHBnX7cW7mv9tD4IhvsYTLAmw/s78=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH/RFC] kconfig/lxdialog: make lxdialof a built-in
Date: Sun, 30 Jul 2006 14:42:07 +0200
User-Agent: KMail/1.8.2
Cc: Roman Zippel <zippel@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>,
       Petr Baudis <pasky@suse.cz>
References: <20060727202726.GA3900@mars.ravnborg.org> <Pine.LNX.4.64.0607281348420.6761@scrub.home> <20060728145947.GA29095@mars.ravnborg.org>
In-Reply-To: <20060728145947.GA29095@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301442.07426.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 16:59, Sam Ravnborg wrote:
> > > The double ESC ESC thing I dunno how to fix.
> > 
> > I think the easiest would be to just ignore the first ESC, it matches the 
> > documented behaviour and e.g. mc has the same behaviour. The delay of the 
> > single ESC makes it a bit annoying/confusing to use, so that sticking to 
> > the double ESC is IMO safer.
> > I played with it a little and below is an example, which implements this 
> > behaviour for the menu window. 
> 
> Thanks - will implment this for all the dialog_* functions.

I don't like "double ESC" idea at all.

I am a Midnight Commander user and I use "old ESC mode"
where single ESC works after a delay.

I patched mc to look at KEYBOARD_KEY_TIMEOUT_US environment variable 
so that delay is configurable (instead of hardcoded 0.5 second one).
Will push the patch to mc-devel.

25 millisecond timeout works just fine on local ttys, serial lines,
and over ssh. So I am setting KEYBOARD_KEY_TIMEOUT_US=25000.
--
vda
