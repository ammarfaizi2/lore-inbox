Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129539AbQK1AkC>; Mon, 27 Nov 2000 19:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129575AbQK1Ajw>; Mon, 27 Nov 2000 19:39:52 -0500
Received: from hera.cwi.nl ([192.16.191.1]:54186 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129539AbQK1Ajo>;
        Mon, 27 Nov 2000 19:39:44 -0500
Date: Tue, 28 Nov 2000 01:09:42 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Peter Cordes <peter@llama.nslug.ns.ca>, linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
Message-ID: <20001128010942.A9133@veritas.com>
In-Reply-To: <20001127134251.A8164@veritas.com> <200011272147.WAA19696@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011272147.WAA19696@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Mon, Nov 27, 2000 at 10:47:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 10:47:06PM +0100, Rogier Wolff wrote:
> Andries Brouwer wrote:
> > > access("/dev/tty2", R_OK|W_OK)          = -1 EROFS (Read-only file system)
> 
> > You misunderstand the function of access(). The standard says
> > 
> > [EROFS] write access shall fail if write access is requested
> >         for a file on a read-only file system
> 
> The intent of the "access" call is to tell you if you will be able to
> open the given pathname for the requested permissions. That this is
> inherently racey is not the fault of the access system call.
> 
> The INTENT of this paragraph from the standard is to specify when to
> return the error value EROFS. The "for a -=file=-" part to me
> indicates that a valid interpretation is that this does not apply to
> device nodes.

You optimist!
A standard is not a text that should be read with the attitude
"they write this but I know that they really meant that".
A standard is precise.

In particular it defines the concepts used. For file it says:

File
An object that can be written to, or read from, or both.
A file has certain attributes, including access permissions and type.
File types include regular file, character special file, block special
file, FIFO special file, symbolic link, socket, and directory.
Other types of files may be supported by the implementation.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
