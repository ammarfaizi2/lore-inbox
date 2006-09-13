Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWIMOps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWIMOps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWIMOps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:45:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58284 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750808AbWIMOpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:45:47 -0400
Message-ID: <4508198E.10707@redhat.com>
Date: Wed, 13 Sep 2006 10:45:34 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gatech.edu
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>	 <1158137786.2560.3.camel@localhost>  <4507F453.1040809@watson.ibm.com> <1158151535.2560.20.camel@localhost> <45080262.8050009@watson.ibm.com>
In-Reply-To: <45080262.8050009@watson.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:

> But another trouble you have not mentioned is what happens to pages
> with pending make-volatile that need to and/or have been made stable
> in the meantime. They too need to be removed from this pending list.

At the time where you walk the set of pages (pagevec?) to make
volatile, you can check whether the page flags are still right.

A page that was set to be marked volatile with the hypervisor,
but later turned stable again would have that indicated in its
page flags, right?

-- 
What is important?  What you want to be true, or what is true?
