Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWDSS6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWDSS6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDSS6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:58:08 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:55244 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751152AbWDSS6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:58:06 -0400
Message-ID: <44468817.5060106@novell.com>
Date: Wed, 19 Apr 2006 11:57:27 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 4/11] security: AppArmor - Core access controls
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>	 <20060419174937.29149.97733.sendpatchset@ermintrude.int.wirex.com> <1145470230.3085.84.camel@laptopd505.fenrus.org>
In-Reply-To: <1145470230.3085.84.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote:
>   
>> Verify if profile
>> + * authorizes mask operations on pathname (due to lack of vfsmnt it is sadly
>> + * necessary to search mountpoints in namespace -- when nameidata is passed
>> + * more fully, this code can go away).  If more than one mountpoint matches
>> + * but none satisfy the profile, only the first pathname (mountpoint) is
>> + * returned for subsequent logging.
>>     
> that sounds too bad ;) 
> If I manage to mount /etc/passwd as /tmp/passwd, you'll only find the
> later and your entire security system seems to be down the drain.
>   
If you are a confined process, then you don't get to mount things, for
this reason, among others.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

