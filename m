Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTFOVfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 17:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTFOVfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 17:35:23 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:57101 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262878AbTFOVfU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 17:35:20 -0400
Date: Sun, 15 Jun 2003 23:49:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@infradead.org>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Brian Jackson <brian@mdrx.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615234909.A11481@pclin040.win.tue.nl>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org> <20030615173926.GH1063@wohnheim.fh-wedel.de> <20030615184417.A19712@infradead.org> <20030615175815.GI1063@wohnheim.fh-wedel.de> <20030615190349.A21931@infradead.org> <20030615181424.GJ1063@wohnheim.fh-wedel.de> <20030615191853.A22150@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615191853.A22150@infradead.org>; from hch@infradead.org on Sun, Jun 15, 2003 at 07:18:53PM +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 07:18:53PM +0100, Christoph Hellwig wrote:
> On Sun, Jun 15, 2003 at 08:14:24PM +0200, Jörn Engel wrote:
> > Yes, I agree.  It is any the "Cramfs didn't find it's magic number,
> > now we'll try another filesystem instead.
> 
> The only places where this should happen is mounting the rootfs.
> mount(8) has it's own filesystem type detection code and doesn't
> call mount(2) unless it found a matching filesystem type.

Too optimistic a description.
Any person who likes reliable results will give mount a -t option.
If someone likes to gamble, and doesnt mind system crashes, he'll
omit the -t and let mount guess what the type should have been.
Mount has a battery of heuristics for a handful of filesystems.
If any of these succeeds mount will try that type.
If none succeeds, mount will try consecutively all types listed
in /proc/filesystems for which no heuristic is present.

(Reality is more complicated, but the above is a good first
approximation.)

Andries

