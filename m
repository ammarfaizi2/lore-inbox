Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270808AbTHAPsD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 11:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270809AbTHAPsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 11:48:03 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:36114 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S270808AbTHAPsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 11:48:01 -0400
Message-ID: <3F2A8BAD.5DAD45AC@moving-picture.com>
Date: Fri, 01 Aug 2003 16:47:57 +0100
From: James Pearson <james-p@moving-picture.com>
Organization: Moving Picture Company
X-Mailer: Mozilla 4.7 [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 and 8139too module oddity
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using a vanilla 2.6.0-test2 kernel with 8139too loaded as a module for
eth0 (my only NIC), I get:

# lsmod
Module                  Size  Used by
nfsd                  158048  17 
exportfs                6320  1 nfsd
autofs4                15408  2 
nfs                   147356  4 
lockd                  65104  3 nfsd,nfs
sunrpc                126852  22 nfsd,nfs,lockd
8139too                24096  0 
mii                     5424  1 8139too
crc32                   4720  1 8139too

i.e. states that 8139too is not used ... but it is!

Using 'rmmod 8139too' works - but, unsurprisingly, all network activity
stops ...

Under 2.4.X, 8139too is 'in use' and can't be rmmod'ed.

James Pearson
