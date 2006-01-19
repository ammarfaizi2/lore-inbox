Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWASRQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWASRQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWASRQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:16:52 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:26783 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932436AbWASRQv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:16:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gJmkVpJlRsdGpvaUG5HrHfjWVQv8iuhIyBkqkNQk9guzb7ucu2QoAxnJpzg0MChURXC5sq9RI9kyZpVM+fyYsxBvkmSN8VWggsuF0j2/qbD/4n4bPv5QH4K4r4BpXMw1JNnv2L2mNoLN4m2zBhLZ4OtpY4kAFOgw9Z0dspdPqR4=
Message-ID: <56a8daef0601190916v463d06edp23bbe0b849f81217@mail.gmail.com>
Date: Thu, 19 Jan 2006 09:16:50 -0800
From: John Ronciak <john.ronciak@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: My vote against eepro* removal
Cc: kus Kusche Klaus <kus@keba.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, jesse.brandeburg@intel.com,
       netdev@vger.kernel.org
In-Reply-To: <20060119162056.GP19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <AAD6DA242BC63C488511C611BD51F367323322@MAILIT.keba.co.at>
	 <20060119162056.GP19398@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the watchdog the e100 driver reads all of the status registers
from the actual hardware.  There are 26 (worst case) register reads. 
There is also a spin lock for another check in the watchdog.  It would
still surprise me that all of this would take 500 usec.  If you are
seeing this delay, you can comment out the scheduling of the watchdog
to see if this goes away.  We'll need to narrow down exactly what in
the watchdog is causing the delay

Thanks.

--
Cheers,
John
