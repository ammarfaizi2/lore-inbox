Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWECOL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWECOL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWECOL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:11:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:50031 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965099AbWECOL5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:11:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rGLw5zbuLhcxHU6wjlXwXZkL3yVzrZwhHmHQ6ddn5lLBLq2ii9N6hiHGvkO7Z7+fO4zUj2DM94bPRWIECb2Vis8VAN72q/2lJviKQ992IGXcP2HGYQXaRLtEAwW47hFBJggUCcV2xBHEXkcMru2aDrWBXmRzHXYy8uQ3YIGTUr0=
Message-ID: <9e4733910605030711p2acab747g8f2ea7fdbb95f3c4@mail.gmail.com>
Date: Wed, 3 May 2006 10:11:52 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 11/14] Reworked patch for labels on user space messages
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1FaVfH-000531-LX@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1FaVfH-000531-LX@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something seems to be wrong in selinux_get_task_sid. I am getting
thousands of these and can't boot the kernel.

May  3 08:51:53 jonsmirl kernel: Code: 00 00 c3 83 3d 60 c3 32 c0 00
74 09 8b 40 24 8b 40 08 89 02 c3 c7 02 00 00 00 00 c3 83 3d 60 c3 32
c0 00 74 0c 8b 80 90 04 00 00 <8b> 40 08 89 02 c3 c7 02 00 00 00 00 c3
83 3d 60 c3 32 c0 00 74
May  3 08:51:53 jonsmirl kernel: EIP: [<c01b3918>]
selinux_get_task_sid+0xf/0x1c SS:ESP 0068:e9b5cd9c
May  3 08:51:53 jonsmirl kernel:  <1>BUG: unable to handle kernel NULL
pointer dereference at virtual address 00000008
May  3 08:51:53 jonsmirl kernel:  printing eip:
May  3 08:51:53 jonsmirl kernel: c01b3918
May  3 08:51:53 jonsmirl kernel: *pde = 00000000
May  3 08:51:53 jonsmirl kernel: Oops: 0000 [#25]
May  3 08:51:53 jonsmirl kernel: SMP
May  3 08:51:53 jonsmirl kernel: Modules linked in: af_packet
xt_length ipt_ttl xt_tcpmss ipt_TCPMSS iptable_mangle xt_multiport
xt_limit ipt_tos nfsd exportfs lockd sunrpc ipv6 autofs4 snd_usb_audio
snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd_page_alloc snd_usb_lib snd_rawmidi
snd_seq_device snd_hwdep snd soundcore ip_conntrack_netbios_ns
ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter
ip_tables x_tables nls_iso8859_1 nls_cp437 vfat fat evdev usbhid video
thermal processor fan button battery ac lp parport_pc parport floppy
ohci1394 ieee1394 uhci_hcd ehci_hcd e1000 i2c_i801 i2c_core
i82875p_edac hw_random edac_mc rtc usbcore unix
May  3 08:51:53 jonsmirl kernel: CPU:    0
May  3 08:51:53 jonsmirl kernel: EIP:    0060:[<c01b3918>]    Not tainted VLI
May  3 08:51:53 jonsmirl kernel: EFLAGS: 00010202   (2.6.17-rc3 #122)
May  3 08:51:53 jonsmirl kernel: EIP is at selinux_get_task_sid+0xf/0x1c
May  3 08:51:53 jonsmirl kernel: eax: 00000000   ebx: e944e000   ecx:
00000000   edx: f7bb9428
May  3 08:51:53 jonsmirl kernel: esi: e944eebc   edi: f7bb9408   ebp:
f7bb93d8   esp: e944ed9c
May  3 08:51:53 jonsmirl kernel: ds: 007b   es: 007b   ss: 0068
May  3 08:51:53 jonsmirl kernel: Process gdm-binary (pid: 3159,
threadinfo=e944e000 task=f7d9e580)
May  3 08:51:53 jonsmirl kernel: Stack: <0>c02622c8 00000004 e944ee46
e944ef3c c17fa8ac 00000000 00000000 e944ee60
May  3 08:51:53 jonsmirl kernel:        00000c57 00000000 00000000
00000000 00000000 c029fda0 e9b50904 00000078
May  3 08:51:53 jonsmirl kernel:        e944ef3c c024db1c 00000078
c01627af e944ee58 00000000 00000001 ffffffff
May  3 08:51:53 jonsmirl kernel: Call Trace:
May  3 08:51:53 jonsmirl kernel:  <c02622c8>
netlink_sendmsg+0x19f/0x280   <c024db1c> sock_sendmsg+0xd4/0xef
May  3 08:51:53 jonsmirl kernel:  <c01627af> __d_lookup+0x96/0xd5  
<c0127b5c> autoremove_wake_function+0x0/0x35
May  3 08:51:53 jonsmirl kernel:  <c015bfb5>
__link_path_walk+0xbab/0xce8   <c0159ed6> do_lookup+0x4f/0x135
May  3 08:51:53 jonsmirl kernel:  <c017cbbf>
proc_pid_readlink+0x102/0x10c   <c024ebda> sys_sendto+0x116/0x140
May  3 08:51:53 jonsmirl kernel:  <c013a014> __alloc_pages+0x55/0x26c 
 <c013ffee> __handle_mm_fault+0x168/0x6d9
May  3 08:51:53 jonsmirl kernel:  <c024f5db>
sys_socketcall+0x17b/0x261   <c0102813> sysenter_past_esp+0x54/0x75


On 5/1/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> From: Steve Grubb <sgrubb@redhat.com>
> Date: Mon Apr 3 09:08:13 2006 -0400
>
> The below patch should be applied after the inode and ipc sid patches.
> This patch is a reworking of Tim's patch that has been updated to match
> the inode and ipc patches since its similar.
>
> [updated:
> >  Stephen Smalley also wanted to change a variable from isec to tsec in the
> >  user sid patch.                                                              ]
>
> Signed-off-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> ---
>
>  include/linux/netlink.h    |    1 +
>  include/linux/selinux.h    |   16 ++++++++++++++++
>  kernel/audit.c             |   22 +++++++++++++++++++---
>  net/netlink/af_netlink.c   |    2 ++
>  security/selinux/exports.c |   11 +++++++++++
>  5 files changed, 49 insertions(+), 3 deletions(-)
>
> e7c3497013a7e5496ce3d5fd3c73b5cf5af7a56e
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index f8f3d1c..87b8a57 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -143,6 +143,7 @@ struct netlink_skb_parms
>         __u32                   dst_group;
>         kernel_cap_t            eff_cap;
>         __u32                   loginuid;       /* Login (audit) uid */
> +       __u32                   sid;            /* SELinux security id */
>  };
>
>  #define NETLINK_CB(skb)                (*(struct netlink_skb_parms*)&((skb)->cb))
> diff --git a/include/linux/selinux.h b/include/linux/selinux.h
> index 413d667..4047bcd 100644
> --- a/include/linux/selinux.h
> +++ b/include/linux/selinux.h
> @@ -5,6 +5,7 @@
>   *
>   * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
>   * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> + * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2,
> @@ -108,6 +109,16 @@ void selinux_get_inode_sid(const struct
>   */
>  void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid);
>
> +/**
> + *     selinux_get_task_sid - return the SID of task
> + *     @tsk: the task whose SID will be returned
> + *     @sid: pointer to security context ID to be filled in.
> + *
> + *     Returns nothing
> + */
> +void selinux_get_task_sid(struct task_struct *tsk, u32 *sid);
> +
> +
>  #else
>
>  static inline int selinux_audit_rule_init(u32 field, u32 op,
> @@ -156,6 +167,11 @@ static inline void selinux_get_ipc_sid(c
>         *sid = 0;
>  }
>
> +static inline void selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
> +{
> +       *sid = 0;
> +}
> +
>  #endif /* CONFIG_SECURITY_SELINUX */
>
>  #endif /* _LINUX_SELINUX_H */
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9060be7..7ec9cca 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -390,7 +390,7 @@ static int audit_netlink_ok(kernel_cap_t
>
>  static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  {
> -       u32                     uid, pid, seq;
> +       u32                     uid, pid, seq, sid;
>         void                    *data;
>         struct audit_status     *status_get, status_set;
>         int                     err;
> @@ -416,6 +416,7 @@ static int audit_receive_msg(struct sk_b
>         pid  = NETLINK_CREDS(skb)->pid;
>         uid  = NETLINK_CREDS(skb)->uid;
>         loginuid = NETLINK_CB(skb).loginuid;
> +       sid  = NETLINK_CB(skb).sid;
>         seq  = nlh->nlmsg_seq;
>         data = NLMSG_DATA(nlh);
>
> @@ -468,8 +469,23 @@ static int audit_receive_msg(struct sk_b
>                         ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
>                         if (ab) {
>                                 audit_log_format(ab,
> -                                                "user pid=%d uid=%u auid=%u msg='%.1024s'",
> -                                                pid, uid, loginuid, (char *)data);
> +                                                "user pid=%d uid=%u auid=%u",
> +                                                pid, uid, loginuid);
> +                               if (sid) {
> +                                       char *ctx = NULL;
> +                                       u32 len;
> +                                       if (selinux_ctxid_to_string(
> +                                                       sid, &ctx, &len)) {
> +                                               audit_log_format(ab,
> +                                                       " subj=%u", sid);
> +                                               /* Maybe call audit_panic? */
> +                                       } else
> +                                               audit_log_format(ab,
> +                                                       " subj=%s", ctx);
> +                                       kfree(ctx);
> +                               }
> +                               audit_log_format(ab, " msg='%.1024s'",
> +                                        (char *)data);
>                                 audit_set_pid(ab, pid);
>                                 audit_log_end(ab);
>                         }
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 2a233ff..09fbc4b 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -56,6 +56,7 @@ #include <linux/bitops.h>
>  #include <linux/mm.h>
>  #include <linux/types.h>
>  #include <linux/audit.h>
> +#include <linux/selinux.h>
>
>  #include <net/sock.h>
>  #include <net/scm.h>
> @@ -1157,6 +1158,7 @@ static int netlink_sendmsg(struct kiocb
>         NETLINK_CB(skb).dst_pid = dst_pid;
>         NETLINK_CB(skb).dst_group = dst_group;
>         NETLINK_CB(skb).loginuid = audit_get_loginuid(current->audit_context);
> +       selinux_get_task_sid(current, &(NETLINK_CB(skb).sid));
>         memcpy(NETLINK_CREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
>
>         /* What can I do? Netlink is asynchronous, so that
> diff --git a/security/selinux/exports.c b/security/selinux/exports.c
> index 7357cf2..ae4c73e 100644
> --- a/security/selinux/exports.c
> +++ b/security/selinux/exports.c
> @@ -5,6 +5,7 @@
>   *
>   * Copyright (C) 2005 Red Hat, Inc., James Morris <jmorris@redhat.com>
>   * Copyright (C) 2006 Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
> + * Copyright (C) 2006 IBM Corporation, Timothy R. Chavez <tinytim@us.ibm.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2,
> @@ -61,3 +62,13 @@ void selinux_get_ipc_sid(const struct ke
>         *sid = 0;
>  }
>
> +void selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
> +{
> +       if (selinux_enabled) {
> +               struct task_security_struct *tsec = tsk->security;
> +               *sid = tsec->sid;
> +               return;
> +       }
> +       *sid = 0;
> +}
> +
> --
> 1.3.0.g0080f
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Jon Smirl
jonsmirl@gmail.com
