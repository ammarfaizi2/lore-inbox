Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWGZQIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWGZQIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWGZQIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:08:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:49194 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751074AbWGZQIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:08:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=sBdTfGOgF0De+TwZdmlo9Ri2nS04mFRtHZ7Ewq03wDr3SoAlwMWEgyfSHXQGOlBjEH0kcdu+MQiDGTVirkCWQ7z16rZ2SUr8oZ50/Mf1/CzHzV3hntBN530ryvzKushGMDEWuKjuHzKanqsJyc5odo6i9gr1htyKlwTZGFOdWr8=
Message-ID: <1f1b08da0607260908u753684c5ocda8b361db65227b@mail.gmail.com>
Date: Wed, 26 Jul 2006 09:08:46 -0700
From: "john stultz" <johnstul@us.ibm.com>
To: "John Richard Moser" <nigelenki@comcast.net>
Subject: Re: gettimeofday(), clock_gettime(), timer_gettime()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44C6D8CD.4040604@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44C6D8CD.4040604@comcast.net>
X-Google-Sender-Auth: 4c78cf1bb84d2698
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/06, John Richard Moser <nigelenki@comcast.net> wrote:
> I'm looking through a few things and noticing some complaints about time
> and performance.  Briefly, the following things have come to my attention:
>
>  - gettimeofday() is slow, or so they say, needing several milliseconds
> to execute.

No. At worse its several microseconds (PIT takes about 18us, and its terrible!).
More likely you'll see ~1us using ACPI PM or HPET or ~500-100ns
(depending on your system).  With vsyscall it can get into the sub
100ns range.

thanks
-john
