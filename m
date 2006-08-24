Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWHXLAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWHXLAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWHXLAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:00:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:985 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751091AbWHXLAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:00:40 -0400
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
From: Arjan van de Ven <arjan@infradead.org>
To: ego@in.ibm.com
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com,
       ashok.raj@intel.com
In-Reply-To: <20060824103417.GE2395@in.ibm.com>
References: <20060824103417.GE2395@in.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 24 Aug 2006 13:00:00 +0200
Message-Id: <1156417200.3014.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 16:04 +0530, Gautham R Shenoy wrote:
> 
> 
> This patch renames lock_cpu_hotplug to cpu_hotplug_disable and
> unlock_cpu_hotplug to cpu_hotplug_enable throughout the kernel.

Hi,

to be honest I dislike the new names too. You turned it into a refcount,
which is good, but the normal linux name for such refcount functions is
_get and _put.....  and in addition the refcount technically isn't
hotplug specific, all you want is to keep the kernel data for the
processor as being "used", so cpu_get() and cpu_put() would sound
reasonable names to me, or cpu_data_get() cpu_data_put().


Greetings,
   Arjan van de Ven

