Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbUKNUCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUKNUCX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUKNUCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:02:23 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:4444 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261346AbUKNUCT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:02:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UNA35xV0umnfi58f85hjJiSbehJWnB7XZxzSq7DkBV041wN+dM4O0Ik84rsrzuD7EBqigskY+AwpbMZcIjs2kDBqirrUnpi6nRDy4W8jAP/OzG2QroY0x46pOwpFZEFgq32iQuQstbA7isvzmJmEPyr3EKnLPh1RG3HZ1+QFnVA=
Message-ID: <64b1faec04111412021fcbcf3f@mail.gmail.com>
Date: Sun, 14 Nov 2004 21:02:18 +0100
From: Sylvain <autofr@gmail.com>
Reply-To: Sylvain <autofr@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: question about module and undeinfed symbols.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0411141948020.30281@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <64b1faec04111410421d76b8fa@mail.gmail.com>
	 <Pine.LNX.4.53.0411141948020.30281@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

thanks you for you response, unfortunatly it appears not to work better :/

I think the problem is isolated, I notices that System.map doesnt
contain same information for my function:
there is the line "c010d480 T myFunction"
but no entry: __ksymtab_myFunction nor __kstrtab_myFunction, 

A warning appear during kernel compilation, on the line: 
EXPORT_SYMBOL(myFunction):

warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
parameter names (without types) in function declaration
data definition has no type of storage classe

seems to me really weird :/

Sylvain


On Sun, 14 Nov 2004 19:48:37 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> 
> >The fonction printk, is also undifened and exported with the same
> >macro "export_symbol". but compilation doesnt complain about it!!
> 
> #include <linux/kernel.h>
> 
> >Am I missing a step somewhere?!
> 
> 
> Jan Engelhardt
> --
> Gesellschaft für Wissenschaftliche Datenverarbeitung
> Am Fassberg, 37077 Göttingen, www.gwdg.de
>
