Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUHDB4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUHDB4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUHDB4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:56:16 -0400
Received: from holomorphy.com ([207.189.100.168]:38328 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267211AbUHDB4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:56:03 -0400
Date: Tue, 3 Aug 2004 18:55:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, pbadari@us.ibm.com
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040804015541.GG2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gerrit Huizenga <gh@us.ibm.com>, Rik van Riel <riel@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>, Chris Wright <chrisw@osdl.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, pbadari@us.ibm.com
References: <Pine.LNX.4.44.0408032122210.5948-100000@dhcp83-102.boston.redhat.com> <E1BsAiE-0008LT-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BsAiE-0008LT-00@w-gerrit2>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2004 21:22:45 EDT, Rik van Riel wrote:
>> OK.  Do any of those do the "root chowns an unnamed
>> hugetlbfs file" scenario ? ;)

On Tue, Aug 03, 2004 at 06:37:02PM -0700, Gerrit Huizenga wrote:
> Badari will probably know the access method for DB2 better than
> I do.  I know they go quite out of their way to avoid having
> root permissions at any point in time.  How they accomplish this
> in the current source base, I don't know.  They were using
> capabilities for things like this for a while.

IIRC the program launcher acquires the capabilities prior to dropping
root privileges and acquires the shm segment prior to exec.


-- wli
