Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTFOSFI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTFOSFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:05:07 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:59152 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262499AbTFOSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:05:02 -0400
Date: Sun, 15 Jun 2003 19:18:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, Brian Jackson <brian@mdrx.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [PATCH] make cramfs look less hostile
Message-ID: <20030615191853.A22150@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org, Brian Jackson <brian@mdrx.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>
References: <20030615160524.GD1063@wohnheim.fh-wedel.de> <20030615182642.A19479@infradead.org> <20030615173926.GH1063@wohnheim.fh-wedel.de> <20030615184417.A19712@infradead.org> <20030615175815.GI1063@wohnheim.fh-wedel.de> <20030615190349.A21931@infradead.org> <20030615181424.GJ1063@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030615181424.GJ1063@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Sun, Jun 15, 2003 at 08:14:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 08:14:24PM +0200, Jörn Engel wrote:
> Yes, I agree.  It is any the "Cramfs didn't find it's magic number,
> now we'll try another filesystem instead.

The only places where this should happen is mounting the rootfs.
mount(8) has it's own filesystem type detection code and doesn't
call mount(2) unless it found a matching filesystem type.

