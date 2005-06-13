Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFMRi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFMRi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFMRi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:38:26 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:5456 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261153AbVFMRiY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:38:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TimhoPY0HkYtuEKAN7AsQEwvzAjCmPkBurt1SsemXFHKl47Aj0J/zCKqeQ/N9oQKQNYDJZiRFEGKVoyky2zqmkt2pfsc9Sq5ARgIfsAb/h9XSjSVdEoGulNKyrvzQElTw6TuydhsikMQQH0rMc0df5ZKQiAjYTe6FwbA/y2zCbk=
Message-ID: <f192987705061310385260ca06@mail.gmail.com>
Date: Mon, 13 Jun 2005 21:38:23 +0400
From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Reply-To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118673175.898.55.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <1118664352.898.16.camel@tara.firmix.at>
	 <f1929877050613065461ad3253@mail.gmail.com>
	 <1118673175.898.55.camel@tara.firmix.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/05, Bernd Petrovitsch <bernd@firmix.at> wrote:
> > The main idea of VFS is that you can access your files in the same way
> > on any supported file system. But actually you can't simple access
> > different-encoded non-ascii files on a filesystem that has no NLS,
> > like ext or reiser.
> 
> I don't think that any filesystem knows about the encoding of every
> filename - after all it is up to the user which encoding he uses for a
> given file (and no, no one forces me to use the same encoding on the
> names of all of "mine" files).
> IOW given a FAT filesystem on an USB stick, which codepage should be
> used?
 
Yes, most if not all filesystems don't have any information about file
names encoding, but the user can often guess it. Hawing files with
differently-encoded names on the same filesystem is nonsense, which
could only appear because of the current NLS misfeatures.

> Perhaps it makes sense to start a prototype with a FUSE (or similar)
> module. You could use standard libs to convert without messing around in
> the kernel (and I don't think someone wants to have an encoding
> conversion layer in the kernel).

We already have it in the kernel, it's called nls and it's up to the
file system implementation to decide to use it or not. I don't
contrive something new, I just want the existing system to work a bit
different.
