Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUEKKeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUEKKeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 06:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUEKKeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 06:34:21 -0400
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:40033 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S262450AbUEKKeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 06:34:19 -0400
Message-ID: <40A0AC1F.2050209@samwel.tk>
Date: Tue, 11 May 2004 12:34:07 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: nl, en-us, en
MIME-Version: 1.0
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch: doc. bug: Linux 2.6.6 laptop-mode
References: <xb7pt9bqojn.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7pt9bqojn.fsf@savona.informatik.uni-freiburg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks good to me, thanks!

--Bart

Sau Dan Lee wrote:

> The script  /etc/acpi/actions/battery.sh in the  document doesn't run,
> because of a wrong name.
> 
> 
> --- linux-2.6.6/Documentation/laptop-mode.txt	2004/05/11 09:46:04	1.1
> +++ linux-2.6.6-laptopmode-docfix/Documentation/laptop-mode.txt	2004/05/11 09:48:17	1.2
> @@ -466,29 +466,29 @@
>  ACAD_HD=244
>  BATT_HD=4
>  
>  # ac/battery event handler
>  
>  status=`awk '/^state: / { print $2 }' /proc/acpi/ac_adapter/AC/state`
>  
>  case $status in
>          "on-line")
>                  echo "Setting HD spindown to 2 hours"
> -                /sbin/laptop-mode stop
> +                /sbin/laptop_mode stop
>                  /sbin/hdparm -S $ACAD_HD /dev/hda > /dev/null 2>&1
>                  /sbin/hdparm -B 255 /dev/hda > /dev/null 2>&1
>                  #echo -n $ACAD_CPU:$ACAD_THR > /proc/acpi/processor/CPU0/limit
>                  exit 0
>          ;;
>          "off-line")
>                  echo "Setting HD spindown to 20 seconds"
> -                /sbin/laptop-mode start
> +                /sbin/laptop_mode start
>                  /sbin/hdparm -S $BATT_HD /dev/hda > /dev/null 2>&1
>                  /sbin/hdparm -B 1 /dev/hda > /dev/null 2>&1
>                  #echo -n $BATT_CPU:$BATT_THR > /proc/acpi/processor/CPU0/limit
>                  exit 0
>          ;;
>  esac
>  ---------------------------/etc/acpi/actions/battery.sh END-------------------------------------------
>  
>  Monitoring tool
>  ---------------
> 
> 
> 
