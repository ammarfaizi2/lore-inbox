Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbTHQMqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbTHQMqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:46:35 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:62226 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269578AbTHQMqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:46:35 -0400
Date: Sun, 17 Aug 2003 13:46:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dominik Strasser <Dominik.Strasser@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030817134633.A7881@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dominik Strasser <Dominik.Strasser@t-online.de>,
	linux-kernel@vger.kernel.org
References: <3F3F782C.2030902@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F3F782C.2030902@t-online.de>; from Dominik.Strasser@t-online.de on Sun, Aug 17, 2003 at 02:42:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 02:42:20PM +0200, Dominik Strasser wrote:
> scsi.h uses "u8" which doesn't seem to be defined.
> Better use u_char.

It's defined in <linux/types.h> as is u_char.  But we generally prefer
explicitly sized types in Linux - and u_char is a BSDism, the right
not explicitly sized type would be unsigned char.

