Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbTFLLAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264814AbTFLLAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:00:54 -0400
Received: from mail.zmailer.org ([62.240.94.4]:33741 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S264813AbTFLLAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:00:53 -0400
Date: Thu, 12 Jun 2003 14:14:37 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: open(.. O_DIRECT ..) difference in between Linux and FreeBSD ..
Message-ID: <20030612111437.GE28900@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been debugging long and hard a thing where IO is done
with O_DIRECT flag applied to open(2).

Unlike Linux, FreeBSD (where this flag originates, apparently) does
_not_ require that read()/write() happens from page aligned memory
areas, and/or be of page-size multiples in size.

This needs at least wording in  open(2) man-page, possibly code
changes in the kernel to support alike behaviour.

/Matti Aarnio
