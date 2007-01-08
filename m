Return-Path: <linux-kernel-owner+w=401wt.eu-S932184AbXAHWyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbXAHWyG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbXAHWyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:54:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47346 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184AbXAHWyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:54:04 -0500
Date: Mon, 8 Jan 2007 22:54:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Chinner <dgc@sgi.com>
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make BH_Unwritten a first class bufferhead flag
Message-ID: <20070108225402.GA24787@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Chinner <dgc@sgi.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20070108224932.GZ33919298@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108224932.GZ33919298@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this doesn't look like a full first class flag to me yet.  Don't
we need to check for buffer_unwritten in the places we're checking
for buffer_delay so we can stop setting buffer_delay for unwritten
buffers?
