Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbTAOPri>; Wed, 15 Jan 2003 10:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbTAOPri>; Wed, 15 Jan 2003 10:47:38 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:23303 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266660AbTAOPrg>; Wed, 15 Jan 2003 10:47:36 -0500
Date: Wed, 15 Jan 2003 15:56:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-security-module@wirex.com, viro@math.psu.edu
Subject: Re: [RFC] Changes to the LSM file-related hooks for 2.5.58
Message-ID: <20030115155624.A15189@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, ak@muc.de,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@wirex.com, viro@math.psu.edu
References: <200301151544.KAA17539@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301151544.KAA17539@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Jan 15, 2003 at 10:44:52AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 10:44:52AM -0500, Stephen D. Smalley wrote:
> 
> "Andi Kleen" <ak@muc.de> writes:
> > Adding release_private_file requires fixing all code that uses 
> > init_private_file (including possible third party code). Otherwise
> > you have some subtle leak. It would better to rename init_private_file to
> > some other name and add appropiate comments so that this can be catched 
> > easily at compile time.
> 
> Thanks for the suggestion.  I've split out this logical change into a
> separate patch and reworked it in accordance with your suggestion.  See
> below.  Let me know if this does not address your concern.

Once you're at it please aqdd an argument to set file.f_flags so the
caller can set O_LARGEFILE properly.  The (unmerged) XFS dmapi code wants
that.

