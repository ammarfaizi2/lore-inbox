Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131094AbQLQTOb>; Sun, 17 Dec 2000 14:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130668AbQLQTOW>; Sun, 17 Dec 2000 14:14:22 -0500
Received: from gate.in-addr.de ([212.8.193.158]:61199 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S129562AbQLQTOI>;
	Sun, 17 Dec 2000 14:14:08 -0500
Date: Sun, 17 Dec 2000 19:43:35 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:  Monitoring filesystems / blockdevice for errors
Message-ID: <20001217194334.V5323@marowsky-bree.de>
In-Reply-To: <20001217153453.O5323@marowsky-bree.de> <Pine.LNX.4.10.10012171314050.16143-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <Pine.LNX.4.10.10012171314050.16143-100000@coffee.psychology.mcmaster.ca>; from "Mark Hahn" on 2000-12-17T13:23:52
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2000-12-17T13:23:52,
   Mark Hahn <hahn@coffee.psychology.mcmaster.ca> said:

> > Short of parsing syslog messages, which isn't particularly great.
> what's wrong with it?

Because it means having to know about all potential messages the filesystems
might dump out.

> reinventing /proc/kmsg and klogd would be tre gross.

Well, only one process can read kmsg and get notified about new messages at
any time, so that makes the monitoring depend on klogd/syslogd working, which
given a write error by syslog might not be the case...

> > I don't have a real idea how this could be added, short of adding a field to
> > /proc/partitions (error count) or something similiar.
> for reporting errors, that might be OK, but it's not a particularly nice
> _notification_ mechanism...

Well, yes.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
