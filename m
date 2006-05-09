Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWEIHmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWEIHmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWEIHmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:42:23 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:55711 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751428AbWEIHmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:42:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dPVo8DwZOURvtVkUOdwrayM+Oz7fI5PSOm9j9AsbS2I2Iz9Z++tsu79nkj9I5fErrtNv1V3YX5ECykdBznL29kuUc38lqTVQsvAMy2w6ic4rlITPKEfVpj5AvUPvTu4xRjroTFTrUKganQG50MAQ4SeVoFfTJPiL9OH9X3kMCoU=  ;
Message-ID: <44602F32.1060909@yahoo.com.au>
Date: Tue, 09 May 2006 15:57:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050831 Debian/1.7.8-1sarge2
X-Accept-Language: en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org> <20060509035320.GC784@in.ibm.com> <44601933.2040905@yahoo.com.au> <20060509054556.GG784@in.ibm.com>
In-Reply-To: <20060509054556.GG784@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

>
>I expect/hope that the CONFIG will be turned on. There is a boot
>option (called delayacct) to enable/disable the statistics collection.
>Once turned on and enabled, all tasks will be filling in/using the statistics.
>

Well they'll be _collecting_ the stats, yes. Will they really be using
them for anything?

If you make the whole thing much lighter weight for tasks which aren't
using the accounting, you have a better chance of people turning the
CONFIG option on.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
