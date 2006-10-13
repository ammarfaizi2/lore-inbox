Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWJMRq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWJMRq5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWJMRq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:46:57 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:27887 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751495AbWJMRq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:46:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=SQkx2SzS7xbnhcRWmAHB3cguGhXrg7FPN7Y7/WRc8Y4wFW2WOldOVyIc5c0NnrFs3slg2+83R73bqv5lY3lee+uaPnCCR5y1dYgKVTkDs4PkLF+OP7WzMER2Jjnxmob8a6kTXeWkAJ/y4vvQhAxNeWs5mcCiY29zf1ne+BlCe3U=
Date: Sat, 14 Oct 2006 02:47:24 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 1/7] documentation and scripts
Message-ID: <20061013174724.GB29079@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ak@suse.de, Don Mullis <dwm@meer.net>
References: <20061012074305.047696736@gmail.com> <452df215.7ab6aae9.17a4.58b5@mx.google.com> <20061012143713.3f6030c8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012143713.3f6030c8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:37:13PM -0700, Andrew Morton wrote:

> So I wonder if it'd be better to make this have units of "one millionth",
> or simply make this tunable "1/(probability of failure)".  So setting it to
> 1,000,000 gives you one failure per million calls, on average.

/debug/*/interval is available for this purpose.
The combination of below commands gives one failure per million calls.

# echo 1000000 > /debug/failslab/interval
# echo 100 > /debug/failslab/probability

