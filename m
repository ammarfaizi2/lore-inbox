Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423561AbWJaQd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423561AbWJaQd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423570AbWJaQd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:33:26 -0500
Received: from zrtps0kn.nortel.com ([47.140.192.55]:29613 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1423561AbWJaQdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:33:25 -0500
Message-ID: <45477ACA.7060303@nortel.com>
Date: Tue, 31 Oct 2006 10:33:14 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
CC: Paul Jackson <pj@sgi.com>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, menage@google.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org>	<20061030062332.856dcc32.pj@sgi.com> <45460E69.7070505@openvz.org> <20061030071838.7988d3e1.pj@sgi.com> <454619B9.8030705@openvz.org>
In-Reply-To: <454619B9.8030705@openvz.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2006 16:33:19.0698 (UTC) FILETIME=[4643B320:01C6FD0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
> Paul Jackson wrote:

> I agree, but you've cut some importaint questions away,
> so I ask them again:
> 
>  > What if if user creates a controller (configfs directory)
>  > and doesn't remove it at all. Should controller stay in
>  > memory even if nobody uses it?
> 
> This is importaint to solve now - wether we want or not to
> keep "empty" beancounters in memory. If we do not then configfs
> usage is not acceptible.

I can certainly see scenarios where we would want to keep "empty" 
beancounters around.

For instance, I move all the tasks out of a group but still want to be 
able to obtain stats on how much cpu time the group has used.

Maybe we can do that without persisting the actual beancounters...I'm 
not familiar enough with the code to say.

Chris
