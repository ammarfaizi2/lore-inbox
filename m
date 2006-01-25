Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWAYDXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWAYDXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 22:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWAYDXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 22:23:04 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:56068 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750995AbWAYDXC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 22:23:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L5C7Lwo4gPL4kS/5eER4jDvz+24pQdIvbHLvjpBQpBzKAX2VMag40tC/+ZoLckK/SdqRkZ9xEInqNm6GL/Kq/mdGbOIWhRMWoda55reTA7ga/M+bMG9VvSJJUw1FDGVs7kElCvr2TUWlU1/79E8FZSpO71LglquaXBh827L6StI=
Message-ID: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
Date: Tue, 24 Jan 2006 22:23:00 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt writes:

> Where is the difference between SG_IO-on-hdx and sg0?

It's like the /dev/ttyS* and /dev/cua* situation, where
we also ended up with multiple device files. This is bad.

SG_IO-on-hdx is modern. It properly associates everything
with one device, which you may name as desired.

sg0 is useful for devices that are not disk, tape, or CD.
A decade ago, it was also the proper way to send raw SCSI
commands to other devices. For nasty compatibility reasons,
Linux still assigns /dev/sg* devices for disk, tape, and CD.
