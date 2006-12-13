Return-Path: <linux-kernel-owner+w=401wt.eu-S932662AbWLMSRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWLMSRQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWLMSRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:17:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:49139 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbWLMSRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:17:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=QNI3A9n5FuDjE0o91ksBTUZnm1ct7v6URnHb7ZTgmx5SNoiID4CyzyhAD270tFkHIT9sA3iU2ICkdVTF7HmUOdTzog1JhECGXU7h/8Pmk2vVaSEHFzHZhpUb2P+vHNlaveAUK7hXic9CjBGSWMBFg3pn6qRWEhakIP2kAOV7PRE=
Message-ID: <5b8e20700612131017n1cd8aff3qbe41351435427e25@mail.gmail.com>
Date: Wed, 13 Dec 2006 13:17:12 -0500
From: "Michael Bommarito" <mjbommar@umich.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-git19] BUG due to bad argument to ieee80211softmac_assoc_work
Cc: netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 5653c73a06918ceb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This didn't get much attention on bugzilla and I figured it was
important enough to forward along to the whole list since it's been
lingering around in ieee80211-softmac since 19-git5 at least.
http://bugzilla.kernel.org/show_bug.cgi?id=7657

Somebody was passing the whole mac device structure to
ieee80211softmac_assoc_work instead of just the assocation work, which
lead to much death and locking.

Attached is a patch that fixes this (the actual change is two lines
but context provided in patch for review).  The dmesg containing call
trace is attached to the bugzilla entry above.

-Mike
