Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTJPR3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTJPR3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:29:48 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:21896 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263062AbTJPR3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:29:47 -0400
Date: Thu, 16 Oct 2003 10:29:30 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Cc: val@nmt.edu
Subject: Re: Transparent compression in the FS
Message-ID: <20031016172930.GA5653@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, val@nmt.edu
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016162926.GF1663@velociraptor.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> Josh and others should take a look at Plan9's venti file storage method 
> -- archival storage is a series of unordered blocks, all of which are 
> indexed by the sha1 hash of their contents.  This magically coalesces 
> all duplicate blocks by its very nature, including the loooooong runs of 
> zeroes that you'll find in many filesystems.  I bet savings on "all 
> bytes in this block are zero" are worth a bunch right there.

The only problem with this is that you can get false positives.  Val Hensen
recently wrote a paper about this.  It's really unlikely that you get false
positives but it can happen and it has happened in the field.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
