Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWFMWmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWFMWmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWFMWmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:42:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7849 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964789AbWFMWme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:42:34 -0400
Date: Wed, 14 Jun 2006 08:41:55 +1000
From: Nathan Scott <nathans@sgi.com>
To: Avi Kivity <avi@argo.co.il>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060614084155.C888012@wobbly.melbourne.sgi.com>
References: <20060613143230.A867599@wobbly.melbourne.sgi.com> <448EC51B.6040404@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <448EC51B.6040404@argo.co.il>; from avi@argo.co.il on Tue, Jun 13, 2006 at 05:00:59PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 05:00:59PM +0300, Avi Kivity wrote:
> Nathan Scott wrote:
> > Such a change would would indeed break XFS, in exactly the way you

Oh, I should clarify - the suggestion of using sb->s_blocksize/
s_blocksize_bits was what I meant by "would break XFS".

> > suggest Jan - the realtime subvolume does typically use a different
> > blocksize from the data subvolume (the realtime extent size is used,
> > and this can be set per-inode too), and there would now be no way to
> > distinguish this preferred IO size difference.
> 
> It can be made into an inode operation:

*nod* - that'd work fine for our needs here.

cheers.

-- 
Nathan
