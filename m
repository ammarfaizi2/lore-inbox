Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289335AbSAILLL>; Wed, 9 Jan 2002 06:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289338AbSAILKv>; Wed, 9 Jan 2002 06:10:51 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:55769 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289335AbSAILKu>; Wed, 9 Jan 2002 06:10:50 -0500
Date: Wed, 9 Jan 2002 12:10:09 +0100
From: Walter Hofmann <walterh@gmx.de>
To: Kervin Pierre <kpierre@fit.edu>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: fs corruption recovery?
Message-ID: <20020109111009.GD963@aragorn>
In-Reply-To: <3C3BB082.8020204@fit.edu> <20020108200705.S769@lynx.adilger.int> <200201090326.g093QBF27608@vindaloo.ras.ucalgary.ca> <3C3BC38C.7010808@fit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3BC38C.7010808@fit.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2002, Kervin Pierre wrote:

> Do you still have any of those scripts around? Or can you give me a 
> general idea of how you used debugfs to retrieve your files?

SuSE has a ddrescure RPM in their distribution which will do what you
need:

wh@aragorn:~$ /usr/local/frodo/bin/dd_rescue
dd_rescue: (fatal): both input and output have to be specified!
 
dd_rescue Version 0.98, garloff@suse.de, GNU GPL
 ($Id: dd_rescue.c,v 1.22 1999/10/19 23:46:25 garloff Exp $)
dd_rescue copies data from one file (or block device) to another
USAGE: dd_rescue [options] infile outfile
Options: -s ipos    start position in  input file (default=0),
         -S opos    start position in output file (def=ipos);
         -b softbs  block size for copy operation (def=16384),
         -B hardbs  fallback block size in case of errs (def=512);
         -e maxerr  exit after maxerr errors (def=0=infinite);
         -m maxxfer maximum amount of data to be transfered (def=0=inf);
         -l logfile name of a file to log errors and summary to
(def="");
         -r         reverse direction copy (def=forward);
         -t         truncate output file (def=no);
         -w         abort on Write errors (def=no);
         -a         spArse file writing (def=no),
         -A         Always write blocks, zeroed if err (def=no);
         -i         interactive: ask before overwriting data (def=no);
         -f         force: skip some sanity checks (def=no);
         -q         quiet operation,
         -v         verbose operation;
         -V         display version and exit;
         -h         display this help and exit.
Note: Sizes may be given in units b(=512), k(=1024) or M(=1024*1024)
bytes
This program is useful to rescue data in case of I/O errors, because
 it does not necessarily aborts or truncates the output.


Walter
