Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313862AbSEEXnM>; Sun, 5 May 2002 19:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSEEXnL>; Sun, 5 May 2002 19:43:11 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:16390 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313862AbSEEXnL>;
	Sun, 5 May 2002 19:43:11 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sebastian Huber <sebastian-huber@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modversion.h improvement suggestion 
In-Reply-To: Your message of "Sun, 05 May 2002 18:00:51 +0200."
             <E174OQu-0007H2-00@smtp.web.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 May 2002 09:43:00 +1000
Message-ID: <8447.1020642180@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002 18:00:51 +0200, 
Sebastian Huber <sebastian-huber@web.de> wrote:
>So what about a default modversion.h file:
>/* This is an automatically generated file. Do not edit it. */
>#error You have not generated the module versions. You have to ...

No.

It is a big mistake to ship a file and overwrite it under the same
name.  It messes up source repositories.

Any code that has an explicit #include <linux/modversions.h> is broken.
The kernel build automatically includes modversions.h when required.

The build instructions for third party modules should say something
like 

  If your kernel was built with CONFIG_MODVERSIONS=y then add these
  flags to the build for this module
  
  -DMODVERSIONS -include kernel_source_tree/linux/modversions.h

In any case, modversions.h will disappear in kbuild 2.5.

