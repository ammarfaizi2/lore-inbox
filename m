Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVB1V1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVB1V1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVB1V1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:27:18 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:10469 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261741AbVB1V1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:27:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=KHmzUy2DDzNin9SmJ8OrVnkS6xoTsQMe/TYjyKg9l0u7GYmJGdDT5S5OtbQtOHYSslHC3rHsD3vELqRL4bcmq4+zjnuewmPiQC4z8uYXlzFk3XLJgrMAqP5SxFQZNOHyCSFYpjYh8PoX4Ek0vjphKD2d5m55TZIT4Yuqkdb0+fs=
Message-ID: <70fda32050228132743998647@mail.gmail.com>
Date: Mon, 28 Feb 2005 15:27:13 -0600
From: micah milano <micaho@gmail.com>
Reply-To: micah milano <micaho@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [CAN-2005-0204]: AMD64, allows local users to write to privileged IO ports via OUTS instruction
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

CAN-2005-0204 reads:

Linux kernel before 2.6.9, when running on the AMD64 and Intel EM64T
architectures, allows local users to write to privileged IO ports via
the OUTS instruction.

Although this says "before 2.6.9" this *includes* 2.6.8 (and 2.4.29)
as well as  2.6.9 and apparantly it includes 2.6.10 and soon to be
released 2.6.11 based on my browsing through the changelogs and not
seeing a mention of this, or that particular file being changed. I do
see that the particular function where this is located has changed
slightly, the patch still seems applicable.

Kernel 2.4.29 appears to have a similar vulnerability, although this
patch would not apply cleanly to that tree, but looks relatively
trivial to modify appropriately.

Apparantly this hole has not migrated upstream somehow and so I am
posting this message to find out where its at.

REDHAT:RHSA-2005:092
URL:http://www.redhat.com/support/errata/RHSA-2005-092.html

The RedHat bug associated with this is located at:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=148855

A patch to fix the problem is located here (also linked to the RedHat bug):
https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=110424&action=view

This apparantly only affects AMD64 and EM64T.

Thanks,
micah
