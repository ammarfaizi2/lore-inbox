Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTDUAXu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 20:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbTDUAXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 20:23:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51395 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263745AbTDUAXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 20:23:49 -0400
Date: Mon, 21 Apr 2003 01:35:51 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries.Brouwer@cwi.nl
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [CFT] more kdev_t-ectomy
Message-ID: <20030421003551.GL10374@parcelfarce.linux.theplanet.co.uk>
References: <UTC200304202356.h3KNuYK14756.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200304202356.h3KNuYK14756.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 01:56:34AM +0200, Andries.Brouwer@cwi.nl wrote:
 
> [But should anyone want: globally s/kdev_t/dev_t/ and a small edit
> of kdev_t.h suffices.]

Please, don't.  Right now kdev_t instances serve as a useful indicator:
"it's still a mess, FIXME".  There are valid uses of dev_t and global
s/kdev_t/dev_t/ would achieve only one thing - mix them with junk.
