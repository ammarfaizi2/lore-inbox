Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281038AbRKGWf5>; Wed, 7 Nov 2001 17:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281036AbRKGWfr>; Wed, 7 Nov 2001 17:35:47 -0500
Received: from Campbell.cwx.net ([216.17.176.12]:30225 "EHLO campbell.cwx.net")
	by vger.kernel.org with ESMTP id <S281026AbRKGWfh>;
	Wed, 7 Nov 2001 17:35:37 -0500
Date: Wed, 7 Nov 2001 15:35:34 -0700
From: Allen Campbell <lkml@campbell.cwx.net>
To: "Daniel R. Warner" <drwarner@mail.myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Yet another design for /proc. Or actually /kernel.
Message-ID: <20011107153534.A82149@const.>
In-Reply-To: <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl> <3BE98EB8.6000802@mail.myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BE98EB8.6000802@mail.myrealbox.com>; from drwarner@mail.myrealbox.com on Wed, Nov 07, 2001 at 02:42:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 02:42:48PM -0500, Daniel R. Warner wrote:
> Erik Hensema wrote:
> 
> > - Multiple values per file when needed
> > 	A file is a two dimensional array: it has lines and every line
> > 	can consist of multiple fields.
> > 	A good example of this is the current /proc/mounts.
> > 	This can be parsed very easily in all languages.
> 
> 
> > 	No need for single-value files, that's oversimplification.
> <snip>
> 
> 
> This is fine for reading, but it makes it harder for humans to change 
> values in /proc - eg, echo 0 > /proc/sys/net/ipv4/tcp_ecn
> 

'Multiple value' files can be made easy to 'write'.  The only
requirement is each 'field' in the file have a unique label.  Then
it's a common associative array, requiring some generic filesystem
write magic to handle the input:

echo "label:1" > /proc/...

The 'generic write magic' would require (at least, without even
more magic) that all /proc files conform to the schema.  This is
probably a _good_ thing.

-- 
  Allen Campbell       |  Lurking at the bottom of the
  allenc@verinet.com   |   gravity well, getting old.
