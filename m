Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTDPRVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTDPRVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:21:17 -0400
Received: from wireless-216-222-127-29.reno.velocitus.net ([216.222.127.29]:33064
	"EHLO masterhub1.sncorp.intranet.com") by vger.kernel.org with ESMTP
	id S264544AbTDPRVQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:21:16 -0400
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
	hard freeze ( lockup on CPU0)
From: Steve Kinneberg <kinnebergsteve@acmsystems.com>
To: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Linux1394dev <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20030416184528.19c20372.philippe.gramoulle@mmania.com>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
	<20030415160530.2520c61c.akpm@digeo.com>
	<20030416004933.GI16706@phunnypharm.org> 
	<20030416184528.19c20372.philippe.gramoulle@mmania.com>
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Apr 2003 10:32:54 -0700
Message-Id: <1050514375.589.1843.camel@stevek>
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SacMail1/ACMS/SNCorp(Release 5.0.11  |July 24, 2002) at
 04/16/2003 10:32:55 AM,
	Serialize by Router on masterhub1/SNCorp(Release 5.0.11  |July 24, 2002) at
 04/16/2003 10:37:15 AM,
	Serialize complete at 04/16/2003 10:37:15 AM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 09:45, Philippe Gramoullé wrote:
> 
> # dmesg
> oot is not IRM capable, resetting...
> ieee1394: Remote root is not IRM capable, resetting...
> ieee1394: Remote root is not IRM capable, resetting...
> ieee1394: Remote root is not IRM capable, resetting...
> [message repeated 178 times and as long as the DV Camcorder in turned on]

I realize this isn't the problem you're really concerned about, but the
above may happen if you are using a version of the 1394 code off the
linux-2.4 branch prior to the patch I sent to the list Monday that Ben
recently applied.  (You should be able to get around this without
downloading the latest code and recompiling by setting attempt_root=1
when insmodding ohci1394.

-- 
Steve Kinneberg
ACM Systems
3034 Gold Canal Drive
Rancho Cordova, CA  95670
Phone: (916) 463-7987
Email: kinnebergsteve@acmsystems.com

