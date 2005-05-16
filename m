Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVEPHIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVEPHIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 03:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVEPHIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 03:08:40 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:56548 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261417AbVEPHI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:08:28 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
To: linux-kernel@vger.kernel.org
Subject: laptop-mode ruled by amount of cached data rather than elapsed time
From: Elias Oltmanns <oltmanns@uni-bonn.de>
Date: Mon, 16 May 2005 08:08:04 +0100
Message-ID: <87sm0n642z.fsf@denkblock.local>
User-Agent: Gnus/5.1007 (Gnus v5.10.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I\m using laptop mode even when the machine is connected to ac because
it makes a huge difference in terms of noise in a really quiet room.
The only thing that annoys me now is that the disk spins up after 10
minutes even if it has to write back rather small amounts of data. If
I'm just reading, for instance, I don't add any valuable data.
However, in the background syslog may have added another of these ----
mark $timestamp ---- lines in /var/log/messages or the exim4 queue
runner added a line to /var/log/exim4/main.log and the like. I could,
of course, extend the time between write backs but in that case it
would take, say, half an hour until data is actually written to disk
even if there was a huge amount of output. So, my question is whether
there is a way to force data being written back once they have
exceeded a certain limit or, even better, to write back data every 10
minutes if a reasonable amount has accumulated and skip one spin up
otherwise.

Thank you for your help,

Elias
