Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWCYNql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWCYNql (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 08:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWCYNql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 08:46:41 -0500
Received: from mailfe01.tele2.fr ([212.247.154.12]:17603 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751402AbWCYNql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 08:46:41 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Sat, 25 Mar 2006 14:46:25 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: jordan.crouse@amd.com, linux-kernel@vger.kernel.org
Subject: "apm: set display: Interface not engaged" is back on armada laptops [Was: APM Screen Blanking fix]
Message-ID: <20060325134625.GA4593@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	jordan.crouse@amd.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Part of a fix for APM Screen Blanking in
arch/i386/apm.c:apm_console_blank() from Jordan Crouse was:

-       if (error == APM_NOT_ENGAGED) {
+       if (error == APM_NOT_ENGAGED && state != APM_STATE_READY) {

for "Prevent[ing] the error message from printing out twice."

However, this puts the "apm: set display: Interface not engaged"
error back on armada laptops (which was the original need for this if
statement).

I don't see how the error message can get printed twice. Anyway,
a double message on some machines is better than a error on other
machines...

Regards,
Samuel
