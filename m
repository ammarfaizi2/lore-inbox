Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbVLGVM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbVLGVM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbVLGVM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:12:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2510 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751678AbVLGVM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:12:26 -0500
Message-ID: <43975039.3080006@redhat.com>
Date: Wed, 07 Dec 2005 16:12:25 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenny Simpson <theonetruekenny@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: An nfs question ftruncate vs. pwrite
References: <20051207203932.25422.qmail@web34103.mail.mud.yahoo.com>
In-Reply-To: <20051207203932.25422.qmail@web34103.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenny Simpson wrote:

>When a file that is opened with normal flags (O_RDWR|O_CREAT|O_TRUNC|O_LARGEFILE) is on NFS, and
>it is exteded via ftruncate, the new expty pages get read back from the server before the system
>call returns:
>  (from strace -T):
>ftruncate64(3, 41943040)                = 0 <0.063866>
>

Is there a question in there?

If the question is whether the new empty pages get read in from the
server before the ftruncate system call returns, then no, they do not.
They get read in from the server as required in the normal course of
future operations.

    Thanx...

       ps
