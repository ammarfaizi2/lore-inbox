Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUDANNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbUDANNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:13:00 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:17570 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262896AbUDANM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:12:59 -0500
Subject: RE: Flash Media block driver problem!
From: David Woodhouse <dwmw2@infradead.org>
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org,
       "Surendra I." <surendrai@esntechnologies.co.in>
In-Reply-To: <1118873EE1755348B4812EA29C55A972176F95@esnmail.esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A972176F95@esnmail.esntechnologies.co.in>
Content-Type: text/plain
Message-Id: <1080825171.24117.1737.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Thu, 01 Apr 2004 14:12:52 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your mailer is broken and does not include 'References' headers, so your
message isn't associated with the message to which you're replying.

Please try to use a non-broken mail program when communicating in a
public forum.

Also, please make sure you quote properly, and keep your lines to under
80 characters.

On Thu, 2004-04-01 at 15:53 +0530, Jinu M. wrote:
> [jinum] This is not a USB/IDE(ATA)/SCSI based device. The controller is 

Does the device perform translation internally to pretend to be a block
device, or does the host access the flash directly and perform the
translation itself?

If the translation is done by the host, it sounds like your flash
controller should be implemented as an MTD device. There is a set of
helpers to allow a translation layer to be implemented simply -- see the
ftl, nftl and inftl code in the 2.6 kernel for examples.

-- 
dwmw2

