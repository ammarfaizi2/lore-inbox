Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUBJXFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 18:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUBJXFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 18:05:05 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:18704 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S261881AbUBJXFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 18:05:00 -0500
Date: Tue, 10 Feb 2004 15:04:52 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Cc: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Message-ID: <20040210230452.GA15892@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
References: <20040209115852.GB877@schottelius.org> <pan.2004.02.09.13.36.23.911729@smurf.noris.de> <20040210043212.GF18674@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210043212.GF18674@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may cause mental anguish to the close-minded. Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 08:32:12PM -0800, Mike Fedyk wrote:
> On Mon, Feb 09, 2004 at 02:36:24PM +0100, Matthias Urlichs wrote:
> > Hi, Nico Schottelius wrote:
> > 
> > > What Linux supported filesystems support UTF-8 filenames?
> > 
> > Filenames, to the kernel, are a sequence of 8-bit things commonly
> > called "bytes" or "octets", excluding '/' and '\0'.
> > 
> 
> You can have "/" in the filename also, though that could be encoded somehow...

You might be able to have a non-ASCII character that looks
like / but not 0x2f.

I for one do not want open("/var/tpm/diddle", O_WRONLY | O_CREAT)
to create a file "tpm/diddle" in /var just because /var/tpm
doesn't exist.  Fortunately what happens is it fails with
ENOENT.

I expect UTF-8 to have no multi-byte sequences containing NUL
but it might be awkward if a multi-byte sequence contained
0x2F (/).  I would hope that the committees chose to avoid
using symbol and punctuation byte-codes for alphanumeric
sequences.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
