Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUBWSdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbUBWSdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:33:33 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:61667 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261991AbUBWSd0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:33:26 -0500
Message-ID: <403A4765.8010908@austin.ibm.com>
Date: Mon, 23 Feb 2004 12:33:09 -0600
From: Mike Strosaker <strosake@austin.ibm.com>
Reply-To: strosake@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch-specific callout in panic()
References: <40398BFE.1040300@austin.ibm.com> <20040222213438.7682ff7b.akpm@osdl.org>
In-Reply-To: <20040222213438.7682ff7b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> We have the panic_notifier_list in there.  Cannot you hook into that?
> 

panic_notifier_list is not used becasue we need to ensure that the
actions in machine_panic are the last ones taken.  machine_panic may
not return (in the ppc64 case, it calls a firmware routine which does
not return), so any other actions on the list need to be taken first.

Thanks,
Mike
