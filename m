Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUBJXXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 18:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUBJXXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 18:23:17 -0500
Received: from main.gmane.org ([80.91.224.249]:4279 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262425AbUBJXXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 18:23:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Date: Wed, 11 Feb 2004 00:23:02 +0100
Message-ID: <yw1x3c9i5xk9.fsf@kth.se>
References: <20040209115852.GB877@schottelius.org> <pan.2004.02.09.13.36.23.911729@smurf.noris.de>
 <20040210043212.GF18674@srv-lnx2600.matchmail.com>
 <20040210230452.GA15892@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-1862.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:7Sp/6i5xJZst6Sq/PbxELfOQQHU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz <jw@pegasys.ws> writes:

> On Mon, Feb 09, 2004 at 08:32:12PM -0800, Mike Fedyk wrote:
>> On Mon, Feb 09, 2004 at 02:36:24PM +0100, Matthias Urlichs wrote:
>> > Hi, Nico Schottelius wrote:
>> > 
>> > > What Linux supported filesystems support UTF-8 filenames?
>> > 
>> > Filenames, to the kernel, are a sequence of 8-bit things commonly
>> > called "bytes" or "octets", excluding '/' and '\0'.
>> > 
>> 
>> You can have "/" in the filename also, though that could be encoded
>> somehow...
>
> You might be able to have a non-ASCII character that looks
> like / but not 0x2f.
>
> I for one do not want open("/var/tpm/diddle", O_WRONLY | O_CREAT)
> to create a file "tpm/diddle" in /var just because /var/tpm
> doesn't exist.

Just imagine all the possibilities for ambiguous file names it would
open up.

> I expect UTF-8 to have no multi-byte sequences containing NUL
> but it might be awkward if a multi-byte sequence contained
> 0x2F (/).  I would hope that the committees chose to avoid
> using symbol and punctuation byte-codes for alphanumeric
> sequences.

IIRC, UTF-8 doesn't use bytes <128 in any multi-byte sequences.

-- 
Måns Rullgård
mru@kth.se

