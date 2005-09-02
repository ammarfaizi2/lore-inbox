Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVIBQzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVIBQzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 12:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVIBQzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 12:55:36 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:60202 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbVIBQzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 12:55:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=JCutFxHCzg8vA2ANP9GY35PbxEyiH/jVvSxpeIlJjpgdfAoTKjh9UKpdThDq3qWDIwbKRbnPJsowIgH1s9NttThE/bhiXtAKVj5cqVsjUzB53HZCrKmC7qXCw57ye04m5Zy6E6BKfP+z6CZo8DponSnC9HKTgltTdblnTompdXs=
Message-ID: <43188402.40508@gmail.com>
Date: Fri, 02 Sep 2005 10:55:30 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 13-mm1: firmware_loading_store goes berserk on boot.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


during boot, kernel get caught in a hi-speed loop, issuing these msgs.
from the logs, it appears that the 'repeated' catcher is getting 
overwhelmed,
perhaps by message trucation which breaks the pattern.
Ive edited large chunks of repeats that made it into the log.

Sep  2 07:59:36 harpo kernel: firmware_loading_store: unexpected value (0)
Sep  2 07:59:37 harpo last message repeated 83 times
Sep  2 08:01:41 harpo kernel: firmware_loading_store: unexpected value 
(0)ected value (0)
Sep  2 08:01:41 harpo kernel: firmware_loading_store: unexpected value (0)
Sep  2 08:01:45 harpo last message repeated 174017 times
Sep  2 08:05:01 harpo last message repeated 36471 times
Sep  2 08:05:01 harpo crond(pam_unix)[13845]: session opened for user 
root by (uid=0)
Sep  2 08:05:01 harpo kernel: firmware_loading_store: unexpected value (0)
Sep  2 08:05:01 harpo last message repeated 94 times
Sep  2 08:05:12 harpo last message repeated 420578 times
Sep  2 08:05:17 harpo last message repeated 175067 times

Ill send .config etc to anyone interested.

thx
