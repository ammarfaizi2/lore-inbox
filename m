Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161272AbWI2CO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWI2CO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWI2COG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:14:06 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:64146 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161272AbWI2CN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:13:56 -0400
Date: Fri, 29 Sep 2006 03:13:53 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.intel.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       rdunlap@xenotime.net
Subject: Re: [patch 2/2] libata: _SDD support
Message-ID: <20060929021353.GB22082@srcf.ucam.org>
References: <20060928182211.076258000@localhost.localdomain> <20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be paranoia, but:

If I'm reading the code right (I may well not be), you seem to be 
evaulating _GTF before _SDD. The spec (9.9.1.1) claims that _SDD should 
be evaulated before _GTF - we had a couple of bug reports against an 
earlier version of the patch that may have been due to that, but I never 
had a chance to chase them down properly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
