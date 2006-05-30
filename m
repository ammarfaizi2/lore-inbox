Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWE3NzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWE3NzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWE3NzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:55:07 -0400
Received: from rrcs-67-52-50-206.west.biz.rr.com ([67.52.50.206]:61688 "HELO
	out-smtp.licor.com") by vger.kernel.org with SMTP id S932238AbWE3NzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:55:03 -0400
Subject: Re: memcpy_toio on i386 using byte writes even when n%2==0
From: Chris Lesiak <chris.lesiak@licor.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>
In-Reply-To: <44779358.9010703@shaw.ca>
References: <6gMqr-8uW-23@gated-at.bofh.it>  <44779358.9010703@shaw.ca>
Content-Type: text/plain
Date: Tue, 30 May 2006 08:55:01 -0500
Message-Id: <1148997301.4376.88.camel@emerson.licor.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 17:46 -0600, Robert Hancock wrote:
> It does seem a little bit less efficient, but I don't know think it's 
> necessarily a bug. There's no guarantee of what size writes will be used 
> with the memcpy_to/fromio functions.

I shouldn't have made that assumption in the first place, but I suspect
that I am not the only one to have done so.  Probably other hardware
also gets caught not supporting byte enables.
-- 
Chris Lesiak
chris.lesiak@licor.com

