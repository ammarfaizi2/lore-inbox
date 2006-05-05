Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWEEBw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWEEBw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 21:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWEEBw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 21:52:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:27096 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932428AbWEEBw5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 21:52:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RRkzKhXe5ZPMy9HfCYgrsapdUKBAYLSGNtspfm2TkEwb5YX4hM7Oyk+Xv0j9/3y58DucZYpyDcUnqQTQBiLplkEgIZMPMLHPdT/7BN6xGVPIJ+FWvgJNQ1xYpjr4m3eyQe7fhTDMmKSkwOwDeRPT+oNjTCdbOqlFnthQr2aamvA=
Message-ID: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
Date: Thu, 4 May 2006 21:52:56 -0400
From: "Dan Merillat" <harik.attar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kbuild + Cross compiling
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I must be an idiot, but why does Kbuild rebuild every file when cross-compiling?
I'm not editing .config or touching any headers, I'm making tweaks to
a single .c driver,
and it is taking forever due to continual full-rebuilds.

building on i386 for ARCH=arm CROSS_COMPILE=arm-linux-uclibc-

I tried following the logic, but everything is a forced build using
if_changed and if_changed_dep, and I can't read GNU Make well enough
to figure out what it thinks is new.  I know make -d says all the
dependancies are up-to-date, so it's being forced some other way.
