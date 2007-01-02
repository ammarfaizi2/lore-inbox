Return-Path: <linux-kernel-owner+w=401wt.eu-S964970AbXABWGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbXABWGH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbXABWGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:06:07 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50734 "HELO
	mustang.oldcity.dca.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932907AbXABWGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:06:05 -0500
Subject: Re: [2.6.19] Scheduler starvation of audio?
From: Lee Revell <rlrevell@joe-job.com>
To: Shawn Starr <sstarr@platform.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E2AC825D4FC7764DA86D9C8ECA27A2DE065B14@catoexm05.noam.corp.platform.com>
References: <E2AC825D4FC7764DA86D9C8ECA27A2DE065B14@catoexm05.noam.corp.platform.com>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 17:07:04 -0500
Message-Id: <1167775624.6670.89.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-29 at 11:25 -0500, Shawn Starr wrote:
> Hello, 
> 
> If any of you have used a Commodore 64 emulator in Linux (such as vice) noticed when using audio there is severe starvation while other activities of the system are going on. i.e.  moving a window in X or starting another application causing audio to chop (this goes away if you speed up the emulation to 200% then drop it back down to 100% The audio will resume chopping once you perform more activity on the desktop). Note, even increasing the audio buffer of the emulation app to its maximum does not help. Of note, the machine I ran this emulator on had a low load.
> 
> There are times when I hit starvation and I wonder if there's any interesting scheduler patches in -mm that might address this?
> 

Must be an application bug, otherwise more apps would be affected.

The best solution is to use a separate high priority thread for anything
with a real time constraint, like audio playback or capture.

Lee

