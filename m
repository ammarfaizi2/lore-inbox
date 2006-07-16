Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWGPQi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWGPQi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWGPQi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:38:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:3140 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751128AbWGPQiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:38:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NbqeXLvAMe8qY4+YdfGFGUNlZtFme5jL3UGa5EBSbpOmx6w08p5Lr2GXEcsdzdmYYm/D+ZeW2ijgkJOIv1vNzIgbZivRPc3ETsZ3hObqU7+qUL7mQHPyPdYERzrG52ZhZIBHXiZ2IVy4CbKlY1KkTb9DcHl3kzqKXKWLltLd1cw=
Message-ID: <e0e4cb3e0607160938k70819e40g4172f5917045ebf8@mail.gmail.com>
Date: Sun, 16 Jul 2006 09:38:25 -0700
From: "Jonathan Baccash" <jbaccash@gmail.com>
To: "Avi Kivity" <avi@argo.co.il>
Subject: Re: raid io requests not parallel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44B9D2CA.8040306@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e0e4cb3e0607151704o479371afpc9332a08fb84ba09@mail.gmail.com>
	 <44B9D2CA.8040306@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Each head has to service 1024 write requests (compared to just 512 read
> requests).

By that logic, it would take twice as long for my writes to finish.
Why is it taking 4x as long in my parallel test? I don't think any of
the repliers understood my question. What I want to know is, during a
single direct IO write request, I would expect the raid software to
issue the write request to both disks simultaneously. But the evidence
indicates that isn't what is happening. I would expect a raid-1 write
to take about as long to write a single block as a single write to a
single disk (assuming no other disk activity), because I would expect
two writes to happen concurrently.
