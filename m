Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUBDFYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 00:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUBDFYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 00:24:21 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:23718 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266144AbUBDFYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 00:24:20 -0500
Message-ID: <402081F6.9010508@matchmail.com>
Date: Tue, 03 Feb 2004 21:24:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alok Mooley <rangdi@yahoo.com>
CC: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: Active Memory Defragmentation: Our implementation & problems
References: <20040204050915.59866.qmail@web9704.mail.yahoo.com>
In-Reply-To: <20040204050915.59866.qmail@web9704.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alok Mooley wrote:

> The regular buddy freeing function also increases the
>number of free pages. Since we are not actually
>freeing pages (we are just moving them), we do not
>want the original freeing function. But then we could 
>decrease the number of free pages by the same number &
>use the buddy freeing function. Will do. Thanks.
>  
>
Then you need to split the parts you want out into sub-functions and 
call it from the previous callers, and your new use for it...
