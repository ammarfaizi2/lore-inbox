Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbTGaS3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270543AbTGaS3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 14:29:15 -0400
Received: from netva01.getronicsgov.com ([67.105.229.98]:24262 "EHLO
	vahqex2.gfgsi.com") by vger.kernel.org with ESMTP id S267520AbTGaS3N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 14:29:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: incompatible open modes
Date: Thu, 31 Jul 2003 14:29:12 -0400
Message-ID: <6DED202D454D3B4EB7D98A7439218D610C9AB8@vahqex2.gfgsi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: incompatible open modes
Thread-Index: AcNXijhcsf2oAz74SLOCrjHO556dIwABmJww
From: "Ata, John" <John.Ata@DigitalNet.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries,

If that's what's been decided... I presume for backwards compatability,
but it does seem rather odd though.  After all, it seems like O_RDONLY
is supposed to safeguard someone from accidently overwriting a file.
Otherwise why not automatically open everything read/write?  Going down
the same path, what's next: automatically write enabling a file which
has been openend for O_RDONLY the next time someone performs a write
operation on it? ;-)

Take care,
John

-----Original Message-----
From: Andries Brouwer [mailto:aebr@win.tue.nl] 
Sent: Thursday, July 31, 2003 1:36 PM
To: Zack Brown
Cc: Ata, John; Linux Kernel Mailing List
Subject: Re: incompatible open modes


> On Thu, Jul 31, 2003 at 12:09:14PM -0400, Ata, John wrote:

> >    the manpage on "open" states that if a file is opened
"O_RDONLY|O_TRUNC",
> >    the O_TRUNC is either ignored or an error is returned.  The 2.4
kernel
> >    appears to cheerfully truncate the file on open.  I wondered
which
> >    behavior is actually intended.
> >
> >    O_TRUNC
> >        If the file already exists and is a regular file  and  the
open
> >        mode  allows  writing  (i.e.,  is O_RDWR or O_WRONLY) it will
be
> >        truncated to length 0.  
> >        Otherwise the effect of O_TRUNC is unspecified.
> >        (On many Linux versions it will be ignored; on other versions
> >        it will return an error.)

This was just recently discussed, and it became clear that the
parenthetical
remark only led to confusion. It has been deleted. Instead

       The (undefined) effect of O_RDONLY | O_TRUNC various among
       implementations.  On  many  systems  the  file is actually
       truncated.

has been added.

Andries

