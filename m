Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWH3TZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWH3TZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWH3TZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:25:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:24389 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751362AbWH3TZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:25:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=OgBnngh1Jho2CdxQ0OboD7hbNOGhuE+CsprRCLUJ3PHfZqtr8LLd3g6MZEAfBUPvux+FsOGN2Q1OWMtqTjEzYzZzy1+xTcdPShKUOWh5nr9HATG4//+NK71kbrMGGmRzBTTizM0f8AIbn4E3nvmG0cdAbNfblbk5c27fKrfT+0Y=
Date: Wed, 30 Aug 2006 22:23:03 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
Message-ID: <20060830222303.11b35276@localhost>
In-Reply-To: <44F5E01C.3010807@zytor.com>
References: <44F1F356.5030105@zytor.com>
	<200608301856.11125.ak@suse.de>
	<20060830200638.504602e2@localhost>
	<200608301931.14434.ak@suse.de>
	<20060830205136.4f9bfd33@localhost>
	<44F5E01C.3010807@zytor.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 11:59:40 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Alon Bar-Lev wrote:
> > 
> > This is not entirely true...
> > All architectures sets saved_command_line variable...
> > So I can add __init to the saved_command_line and
> > copy its contents into kmalloced persistence_command_line at
> > main.c.
> > 
> 
> My opinion is that you should change saved_command_line (which
> already implies a copy) to be the kmalloc'd version and call the
> fixed-sized buffer something else.
> 
> 	-hpa

Changing saved_command_line is a modification to all
architectures... They all modify this variable...
So, should I submit a patch to all architectures? How can I test this?

Also for i386 the code is assembly... So I can modify the code to write
into a __init buffer and then kmalloc in setup.c.

Please instruct me how to proceed...

Best Regards,
Alon Bar-Lev.
