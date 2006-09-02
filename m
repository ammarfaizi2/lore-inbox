Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWIBBfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWIBBfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWIBBfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:35:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:36189 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750780AbWIBBfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:35:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k2xN1WNykPis7G6k8vN0Pwvkr7oK/raxZuXr2JwJESC0CiX636FLy5Qs35ga1wJmi+5+Ig5mNIloKjoLE2EDl7tgJyxuYZU6fVVjXBHbU/BcDFvKxjh7B6BgcqxuOCpvWQdDGOUOSqTIN/gRhrWO6/zI1zxfInkaCIcV7vYVr6I=
Message-ID: <2c0942db0609011835l4e4bef6ie2d3d7a5ad30b8c0@mail.gmail.com>
Date: Fri, 1 Sep 2006 18:35:01 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: Ethan <thesyntheticsophist@gmail.com>
Subject: Re: File corruption with 2940U2 SCSI card and aic7xxx driver.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ea0b05b30609010905v341ba10ap5a7638e1d91faa5b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ea0b05b30609010905v341ba10ap5a7638e1d91faa5b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/06, Ethan <thesyntheticsophist@gmail.com> wrote:
> I recently installed an Adaptec 2940U2 controller and two disks in my
> Debian Sarge system, kernel version 2.6.8.
[...]
> The original file, "alphabet", contains the line
> "abcdefghijklmnopqrstuvwxyz" repeated many times; however the file
> read from the SCSI drive, "alphabet_ver2", contains a number lines
> like "abcdefghijklmnopqrstubcdefghijklmnopqrstuvwxyz" and
> "abcdopqrstuvwxyz" --- all the correct characters, just out of order.

Well, they're probably not out of order per se, but more than some
data on a page granularity was dropped, duplicated, or something. If
you have a bit of coding skills, I'd suggest writing a bunch of 32-bit
ints to a file, in increasing order, and use that as a test case. That
way each 32-bit word is unique, and you might be able to spot a bit
more of a pattern as to what's going on (is it duplicated? Is it out
of order?).

This might give hints to those with bigger brains than mine.

Ray

-- 
VGER BF report: H 0.222399
