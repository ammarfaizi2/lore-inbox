Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132178AbRAWGhi>; Tue, 23 Jan 2001 01:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135790AbRAWGh2>; Tue, 23 Jan 2001 01:37:28 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:18705 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132178AbRAWGhM>;
	Tue, 23 Jan 2001 01:37:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
cc: Werner.Almesberger@epfl.ch (Werner Almesberger),
        david_luyer@pacific.net.au (David Luyer), alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: "Pass module parameters" to built-in drivers 
In-Reply-To: Your message of "Mon, 22 Jan 2001 21:55:23 -0000."
             <200101222155.f0MLtNe01781@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Jan 2001 17:37:02 +1100
Message-ID: <22446.980231822@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001 21:55:23 +0000 (GMT), 
Russell King <rmk@arm.linux.org.uk> wrote:
>Hmm, don't we already have all that __setup() stuff laying around?  Ok,
>it might not be built into the .o for modules, but it could be.  Could
>we not do something along the lines of:
>
>1. User passes parameters on the kernel command line.
>2. modprobe reads the kernel command line and sorts out those that
>   correspond to the __setup() stuff in the module being loaded.
>3. modprobe combines in any extra settings from /etc/modules.conf
>
>IIRC, this would satisfy the original posters intentions, presumably
>without too much hastle?

Apart from the fact that it is completely backwards from the original
intent.  The problem is objects that have MODULE_PARM but no __setup.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
