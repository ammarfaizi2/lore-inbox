Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269356AbRIFXdx>; Thu, 6 Sep 2001 19:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269390AbRIFXdo>; Thu, 6 Sep 2001 19:33:44 -0400
Received: from rdu25-2-186.nc.rr.com ([24.25.2.186]:20353 "EHLO gateway.house")
	by vger.kernel.org with ESMTP id <S269356AbRIFXda>;
	Thu, 6 Sep 2001 19:33:30 -0400
Subject: RE: nfs is stupid ("getfh failed") -- exporting a mountpoint?
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: "Margulies, Adam" <amarguli@hotjobs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6818BDFB20BD5118B5C00B0D049C021526740@element.ny.genx.net>
In-Reply-To: <A6818BDFB20BD5118B5C00B0D049C021526740@element.ny.genx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 06 Sep 2001 19:34:12 -0400
Message-Id: <999819252.2266.1.camel@gromit.house>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a problem with exporting a mount point? It seems that, as long
as I'm not trying to export "/export", which is where the resierfs
filesystem is mounted, things are working okay. I was exporting /export
and /export/home before, now I'm exporting /export/home and
/export/files, with pretty much everything in /export moved into
/export/files (except for /export/home).

-M

On 06 Sep 2001 11:28:35 -0400, Margulies, Adam wrote:
> I have had similar problems in the past. Everytime I've rebooted my main nfs
> server I've had to reboot my clients of that nfs for things to work
> correctly. If a client remained up and running, I'd get strange errors from
> the server.
> 
> Reiserfs has had some known nfs problems (with known patches) for some time.
> It all seems to have resolved itself with the 2.4.9+ kernels.
> 
> -----Original Message-----
> From: Michael Rothwell [mailto:rothwell@holly-springs.nc.us]
> Sent: Thursday, September 06, 2001 10:36 AM
> To: linux-kernel@vger.kernel.org
> Subject: nfs is stupid ("getfh failed")
> 
> 
> Two systems that worked fine for weeks, both running 2.4.[7,8] kernels. The
> server is running 2.4.8 and exporting a reiserfs filesystem via nfs. Or it
> was, anyway. The server was shut down and brought back up (power failure).
> The client was then
> rebooted.
> 
> server# cat /etc/exports
> /export 192.168.1.*(rw,no_root_squash)
> /export/home 192.168.1.*(rw,no_root_squash)
> 
> client# mount /export
> mount: 192.168.1.1:/export failed, reason given by server: Permission denied
> 
> server# tail /var/log/messages
> Sep  6 09:37:43 gateway rpc.mountd: authenticated mount request from
> 192.168.1.133:933 for /export (/export)
> Sep  6 09:37:43 gateway rpc.mountd: getfh failed: Operation not permitted
> 
> ... so,  rebooting two working systems seems to kill NFS. Any ideas why?
> 
> On a related topic, will Linux ever have a better file-service protocol?
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> ----------------------------------------------------------------------------
> -------------------------------------------------------
> Private and Confidential
> This electronic mail may contain confidential information that is intended
> for the use of the addressee only or others authorized to receive it. If you
> are not the intended recipient, you are hereby notified that any disclosure,
> copying, distribution or taking action in reliance on the contents of the
> information is strictly prohibited. If you receive this mail in error,
> please delete it from your system immediately and notify HotJobs.com, Ltd.
> - support@hotjobs.com 


